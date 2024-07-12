from mbrylqvg5lc2dul1m70f2q_.utils import *

def sales_report_model():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    envs = {"DBT_DATABRICKS_INVOCATION_ENV" : "prophecy"}
    dbt_props_cmd = ""

    if "":
        envs = {"DBT_DATABRICKS_INVOCATION_ENV" : "prophecy", "DBT_PROFILES_DIR" : ""}

    if "":
        dbt_props_cmd = " --profile "

    if "sales_report":
        dbt_props_cmd = dbt_props_cmd + " -m " + "sales_report"

    return BashOperator(
        task_id = "sales_report_model",
        bash_command = " && ".join(
          ["{} && cd $tmpDir/{}".format(
             (
               "set -euxo pipefail && tmpDir=`mktemp -d` && git clone "
               + "{} --branch {} --single-branch $tmpDir".format(
                 "https://github.com/BobProphecy/snow",
                 "dev"
               )
             ),
             ""
           ),            "dbt run" + dbt_props_cmd,  "dbt test" + dbt_props_cmd]
        ),
        env = envs,
        append_env = True,
    )
