from mbrylqvg5lc2dul1m70f2q_.utils import *

def sales_report_model():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    dbt_props_cmd = ""

    if "run_profile":
        dbt_props_cmd = " --profile run_profile"

    if "sales_report":
        dbt_props_cmd = dbt_props_cmd + " -m " + "sales_report"

    return BashOperator(
        task_id = "sales_report_model",
        bash_command = f'''$PROPHECY_HOME/run_dbt.sh "{"; ".join(["dbt run" + dbt_props_cmd, "dbt test" + dbt_props_cmd])}"''',
        env = {
          "DBT_PROFILE_SECRET": "eN9HuovdAgEstFRu58Ho2", 
          "GIT_TOKEN_SECRET": "b9ZQkAGIfWvHMWL1uVU8gg_", 
          "GIT_ENTITY": "branch", 
          "GIT_ENTITY_VALUE": "dev", 
          "GIT_SSH_URL": "https://github.com/BobProphecy/snow", 
          "GIT_SUB_PATH": ""
        },
        append_env = True,
    )
