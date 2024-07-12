import os
import sys
import pendulum
from datetime import timedelta
import airflow
from airflow import DAG
from airflow.models.param import Param
from airflow.decorators import task
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from ts5smysqha75ahrup9x7eq_.tasks import Model_0
PROPHECY_RELEASE_TAG = "__PROJECT_ID_PLACEHOLDER__/__PROJECT_RELEASE_VERSION_PLACEHOLDER__"

with DAG(
    dag_id = "Ts5sMYsqhA75AHRUp9x7EQ_", 
    schedule_interval = "0 0 * * 1", 
    default_args = {"owner" : "Prophecy", "ignore_first_depends_on_past" : True, "do_xcom_push" : True, "pool" : "2AGL95yk"}, 
    start_date = pendulum.today('UTC'), 
    end_date = pendulum.datetime(2024, 7, 2, tz = "UTC"), 
    catchup = False, 
    max_active_runs = 1
) as dag:
    Model_0_op = Model_0()
