import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
from airflow.models.param import Param
from airflow.decorators import task
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from mbrylqvg5lc2dul1m70f2q_.tasks import sales_report_model
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "mbRylqVG5lc2duL1M70F2Q_", 
    schedule_interval = "0 0 * * 1", 
    default_args = {
      "owner": "Prophecy", 
      "email": "bobw@prophecy.io", 
      "email_on_failure": True, 
      "ignore_first_depends_on_past": True, 
      "do_xcom_push": True, 
      "pool": "XL7tAWek"
    }, 
    start_date = pendulum.today('UTC'), 
    end_date = pendulum.datetime(2024, 5, 5, tz = "UTC"), 
    catchup = True, 
    tags = []
) as dag:
    sales_report_model_op = sales_report_model()
