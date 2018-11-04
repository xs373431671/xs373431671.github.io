<%@ WebHandler Language="C#" Class="SendMessage" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class SendMessage : IHttpHandler {

    public void ProcessRequest (HttpContext context)
    {
        context.Response.ContentType = "text/html";
        string userName=context.Request.Form["username"];
        string userMail=context.Request.Form["usermail"];
        string userTheme=context.Request.Form["usertheme"];
        string userContent=context.Request.Form["usercon"];

        string connStr="server=sql.db95.vhostgo.com,1433;database=xs373431671;uid=xs373431671;pwd=songge5211314";
        using(SqlConnection conn=new SqlConnection(connStr))
        {
            using(SqlCommand cmd=new SqlCommand())
            {
                cmd.Connection=conn;
    
                cmd.CommandText = string.Format("insert into Resume (Name,Email,Theme,Content)values('{0}','{1}','{2}','{3}')", userName.Trim(), userMail.Trim(), userTheme.Trim(), userContent.Trim());
                conn.Open();               
                if(cmd.ExecuteNonQuery()>0)
                {

                    context.Response.Write("<h1>发送成功！十分感谢！</h1>");
                }
                else
                {
                    
                    context.Response.Redirect("<h1>不好意思，发送失败！</h1>");
                }
            }
        }

    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }

}