<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Pump_house.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <h3>Водокачка СПРИНТ</h3>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always"
            runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" />
            </Triggers>
            <ContentTemplate>

                <asp:ListView ID="ListView1" runat="server" ItemType="Pump_house.Data_Access.Gardener" SelectMethod="GetGardeners"
                    UpdateMethod="EditGardener" DeleteMethod="DeleteGardener"
                    InsertMethod="InsertGardener" DataKeyNames="Id">
                    <LayoutTemplate>
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Имя</th>
                                <th>Фамилия</th>
                                <th>Адрес</th>
                                <th>Площадь</th>
                                <th>Месяц</th>
                                <th>Счет</th>
                                <th></th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server"></tr>
                        </table>
                    </LayoutTemplate>

                    <ItemTemplate>
                        <tr>
                            <td><%# Item.Id %></td>
                            <td><%# Item.FirstName %></td>
                            <td><%# Item.LastName %></td>
                            <td><%# Item.Address %></td>
                            <td><%# Item.Area %></td>
                            <td><%# Item.Month %></td>
                            <td><%# Item.Bill %></td>
                            <td>
                                <asp:Button CommandName="Edit" runat="server" Text="Изменить" />
                                <asp:Button CommandName="Delete" runat="server" Text="Удалить" />
                            </td>
                        </tr>
                    </ItemTemplate>

                    <EditItemTemplate>
                        <tr>
                            <td><%# Item.Id %></td>
                            <td>
                                <input id="firstName" runat="server" value="<%# BindItem.FirstName%>" /></td>
                            <td>
                                <input id="lastName" runat="server" value="<%# BindItem.LastName %>" /></td>
                            <td>
                                <input id="address" runat="server" value="<%# BindItem.Address %>" /></td>
                            <td>
                                <input id="area" runat="server" value="<%# BindItem.Area %>" /></td>
                            <td>
                                <input id="month" runat="server" value="<%# BindItem.Month %>" /></td>
                            <td>
                                <input id="bill" runat="server" value="<%# BindItem.Bill %>" /></td>
                            <td>
                                <asp:Button CommandName="Update" runat="server" Text="Сохранить" />
                                <asp:Button CommandName="Delete" runat="server" Text="Отмена" />
                            </td>
                        </tr>
                    </EditItemTemplate>

                    <InsertItemTemplate>
                        <tr>
                            <td></td>
                            <td>
                                <input id="firstName" runat="server" value="<%# BindItem.FirstName%>" /></td>
                            <td>
                                <input id="lastName" runat="server" value="<%# BindItem.LastName %>" /></td>
                            <td>
                                <input id="address" runat="server" value="<%# BindItem.Address %>" /></td>
                            <td>
                                <input id="area" runat="server" value="<%# BindItem.Area %>" /></td>
                            <td>
                                <input id="month" runat="server" value="<%# BindItem.Month %>" /></td>
                            <td>
                                <input id="bill" runat="server" value="<%# BindItem.Bill %>" /></td>
                            <td>
                                <asp:Button ID="Button1" CommandName="Insert" runat="server" Text="Вставить" />
                            </td>
                        </tr>
                    </InsertItemTemplate>
                </asp:ListView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <br />
        Выберите месяц:
        <br />
        <br />
        <asp:ListBox ID="lbMonth" runat="server" Width="200px">
            <asp:ListItem Text="Январь" Value="1" />
            <asp:ListItem Text="Февраль" Value="2" />
            <asp:ListItem Text="Март" Value="3" />
            <asp:ListItem Text="Апрель" Value="4" />
            <asp:ListItem Text="Май" Value="5" />
            <asp:ListItem Text="Июнь" Value="6" />
            <asp:ListItem Text="Июль" Value="7" />
            <asp:ListItem Text="Август" Value="8" />
            <asp:ListItem Text="Сентябрь" Value="9" />
            <asp:ListItem Text="Октябрь" Value="10" />
            <asp:ListItem Text="Ноябрь" Value="11" />
            <asp:ListItem Text="Декабрь" Value="12" />
        </asp:ListBox>
        <asp:Button
            ID="btnSubmit"
            Text="Изменить"
            runat="server" OnClick="btnSubmit_Click" />
        <br />
        <br />
        Тариф(руб) на текущий месяц:
        <input id="tarif" runat="server" />
        <br />
        Объем использованной воды:
        <input id="volume" runat="server" />

        <asp:Button ID="btnCalculate" Text="Рассчитать" runat="server" OnClick="btnCalculate_Click" />
    </form>
    <style>
        th, td {
            padding: 8px;
        }

        th {
            background: #28a4fa;
            color: white;
            font-weight: bold;
        }

        tr:nth-of-type(even) {
            background: #eee;
        }

        tr:nth-of-type(odd) {
            background: #fffbd6;
        }
    </style>
</body>
</html>
