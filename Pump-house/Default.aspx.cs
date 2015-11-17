using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Pump_house.Data_Access;

namespace Pump_house
{
    public partial class Default : System.Web.UI.Page
    {
        GardenerModelContainer dbContext;
        public int currentMonth { get; set; }
        public Indication indication = new Indication();
        protected void Page_Load(object sender, EventArgs e)
        {
            dbContext = new GardenerModelContainer();
            ListView1.InsertItemPosition = InsertItemPosition.LastItem;
        }
        //set current month
        public void btnSubmit_Click(object sender, EventArgs eventArgs)
        {
            currentMonth = Convert.ToInt32(lbMonth.SelectedValue);
            ListView1.DataBind();
        }
        //calculate cost
        public void btnCalculate_Click(object sender, EventArgs eventArgs)
        {
            //(тариф*объем/сумму всех площадей)*конкретную площадь
            int month = DateTime.Now.Month;
        
            indication.Tarif = Convert.ToDouble(tarif.Value);
            indication.Volume = Convert.ToDouble(volume.Value);

            List<Gardener> gardeners = new List<Gardener>();
            gardeners = dbContext.Gardeners.Where(g => g.Month == month).ToList();

            int sumArea= gardeners.Sum(gardener => gardener.Area);
            double tmp = (indication.Tarif*indication.Volume)/sumArea;

            foreach (Gardener gardener in gardeners)
            {
                var id = gardener.Id;
                var ga = dbContext.Gardeners.FirstOrDefault(g => g.Id == id);
                ga.Bill += (decimal) (ga.Area * tmp);
            }

                dbContext.SaveChanges();
                Response.Redirect(Request.RawUrl);
        }
        // load gardeners
        public IQueryable<Gardener> GetGardeners()
        {
            int month=DateTime.Now.Month;
            if (currentMonth != 0)
                month = currentMonth;
            return dbContext.Gardeners.AsQueryable<Gardener>().Where(m => m.Month == month);
        }
        
        public void EditGardener(int Id)
        {
            Gardener gardener = dbContext.Gardeners.Where(g => g.Id == Id).FirstOrDefault();

            if (gardener != null && TryUpdateModel<Gardener>(gardener))
            {
                // reload data
                dbContext.Entry<Gardener>(gardener).State = EntityState.Modified;
                dbContext.SaveChanges();
            }
        }
        
        public void DeleteGardener()
        {
            Gardener gardener = new Gardener();

            if (TryUpdateModel<Gardener>(gardener))
            {
                dbContext.Entry<Gardener>(gardener).State = EntityState.Deleted;
                dbContext.SaveChanges();
            }
        }

        public void InsertGardener()
        {
            Gardener gardener = new Gardener();

            if (TryUpdateModel<Gardener>(gardener))
            {
                dbContext.Entry<Gardener>(gardener).State = EntityState.Added;
                dbContext.SaveChanges();
            }
        }
    }
}