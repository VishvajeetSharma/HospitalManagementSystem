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
    public class LaboratorianController : Controller
    {
        //SQL Connection String.........................

        // GET: Laboratorian
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Appointment()
        {
            string query = $"select * from LAB_Appointment left join Pt_Registration on LAB_Appointment.Pt_Id = Pt_Registration.Pt_Id left join Services on LAB_Appointment.TName = Services.Sr order by LAB_Appointment.T_Id desc";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }

        public ActionResult UpdateStatus(int? T_Id, String Status)
        {
            if (T_Id.HasValue && !Status.IsEmpty())
            {
                string query = $"update LAB_Appointment set Status = 'Completed' where T_Id = '{T_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return Content("<script>alert('Status Updated.'); location.href = '/laboratorian/appointment'</script>");
            }
            else
            {
                return Content("<script>alert('Try again !'); location.href = '/laboratorian/appointment'</script>");
            }
        }

        public ActionResult UploadReport(string T_Id)
        {
            string query = $"select * from LAB_Appointment where T_Id = '{T_Id}'";
            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            ViewBag.table = dt;
            return View();
        }
        [HttpPost]
        public ActionResult SaveReport(int? T_Id, HttpPostedFileBase testreport)
        {

            string query = $"update LAB_Appointment set Test_Report = '{testreport.FileName}' where T_Id = '{T_Id}'";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            int r = cmd.ExecuteNonQuery();
            con.Close();

            testreport.SaveAs(Server.MapPath("/Content/testreport/" + testreport.FileName));
            return RedirectToAction("Appointment");
        }

        public ActionResult DeleteLabApp(String T_Id)
        {
            if (!T_Id.IsEmpty())
            {
                string query = $"delete from LAB_Appointment where T_Id = '{T_Id}'";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                con.Close();

                return RedirectToAction("Appointment");
            }
            else
            {
                return Content("<script>alert('Not Deleted! Try Again.'); location.href = '/laboratorian/appointment'</script>");
            }
        }
        public ActionResult logout()
        {
            Session.Remove("Laboratorian");
            return RedirectToAction("Index", "Home");
        }


    }
}