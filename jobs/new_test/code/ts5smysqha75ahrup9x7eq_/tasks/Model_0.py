from ts5smysqha75ahrup9x7eq_.utils import *

def Model_0():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    dbt_props_cmd = ""

    if "run_profile":
        dbt_props_cmd = " --profile run_profile"

    return BashOperator(
        task_id = "Model_0",
        bash_command = f'''$PROPHECY_HOME/run_dbt.sh "{"; ".join(["dbt run" + dbt_props_cmd, "dbt test" + dbt_props_cmd])}"''',
        env = {
          "DBT_DATABRICKS_INVOCATION_ENV": "prophecy", 
          "DBT_PROFILE_SECRET": "", 
          "GIT_TOKEN_SECRET": "", 
          "GIT_ENTITY": "branch", 
          "GIT_ENTITY_VALUE": None, 
          "GIT_SSH_URL": "", 
          "GIT_SUB_PATH": ""
        },
        append_env = True,
    )
