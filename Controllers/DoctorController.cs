using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.WebPages;

namespace HospitalManagementSystem.Controllers
{
    public class DoctorController : Controller
    {
        //SQL Connection String.......................

        // GET: Doctor
        public ActionResult DrProfile()
        {
            int Dr_Id = Convert.ToInt32(Session["Dr_Id"]);
            String query = $"select * from Dr_Registration left join Department on Dr_Registration.Assigned_Department = Department.Sr where Dr_Id = '{Dr_Id}';";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            // select rows from dr appointments
            String query1 = $"select * from Dr_Appointment left join Pt_Registration on Dr_Appointment.Pt_Id = Pt_Registration.Pt_Id where cast(App_Date as datetime) + cast(App_Time as datetime) > getdate() and Dr_Appointment.Dr_Id = '{Dr_Id}' order by cast(App_Date as datetime) + cast(App_Time as datetime) asc";
            SqlDataAdapter sda1 = new SqlDataAdapter(query1, con);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);

            // Select data from Patient Registration table
            string query2 = "select top 5 * from Pt_Registration order by Pt_Id desc";
            SqlDataAdapter sda3 = new SqlDataAdapter(query2, con);
            DataTable dt2 = new DataTable();
            sda3.Fill(dt2);



            ViewBag.table = dt;
            ViewBag.table1 = dt1;
            ViewBag.table2 = dt2;
            return View();
        }

        public ActionResult Patients()
        {
            // Select data from Patient Registration table
            string query = "select * from Pt_Registration order by Pt_Id desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }


        public ActionResult Appointment()
        {
            int Dr_Id = Convert.ToInt32(Session["Dr_Id"]);
            string query = $"select * from Dr_Appointment left join Pt_Registration on Dr_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Dr_Registration on Dr_Appointment.Department = Dr_Registration.Assigned_Department where Dr_Appointment.Dr_Id = '{Dr_Id}'  order by Dr_Appointment.Ap_Id desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        public ActionResult DeleteApp(String Ap_Id)
        {
            if (!Ap_Id.IsEmpty())
            {
                string query = $"delete from Dr_Appointment where Ap_Id = '{Ap_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return RedirectToAction("Appointment");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/doctor/appointment'</script>");
            }
        }
        public ActionResult UpdateStatus(int? Ap_Id, String Status)
        {
            if (Ap_Id.HasValue && !Status.IsEmpty())
            {
                string query = $"update Dr_Appointment set Status = 'Completed' where Ap_Id = '{Ap_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Status Updated.'); location.href = '/doctor/appointment'</script>");
            }
            else
            {
                return Content("<script>alert('Try again !'); location.href = '/doctor/appointment'</script>");
            }
        }


        public ActionResult logout()
        {
            Session.Remove("Dr_Id");
            Session.Remove("Name");
            Session.Remove("Email");
            return Content("<script>alert('Logged out'); location.href = '/home/index'</script>");
        }
    }
}