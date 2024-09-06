from mbrylqvg5lc2dul1m70f2q_.utils import *

def sales_report_model():
    from airflow.operators.python import PythonOperator
    from datetime import timedelta
    import os
    import zipfile
    import tempfile

    return PythonOperator(
        task_id = "sales_report_model",
        python_callable = invoke_dbt_runner,
        op_kwargs = {
          "is_adhoc_run_from_same_project": False,
          "is_prophecy_managed": False,
          "run_deps": False,
          "run_seeds": False,
          "run_parents": False,
          "run_children": False,
          "run_tests": True,
          "run_mode": "model",
          "entity_kind": "model",
          "entity_name": "sales_report",
          "project_id": "22387",
          "git_entity": "tag",
          "git_entity_value": "__PROJECT_FULL_RELEASE_TAG_PLACEHOLDER__",
          "git_ssh_url": "https://github.com/BobProphecy/snow",
          "git_sub_path": "",
          "select": "",
          "threads": "",
          "exclude": "",
          "run_props": "",
          "envs": {"DBT_DATABRICKS_INVOCATION_ENV" : "prophecy"}
        },
    )
