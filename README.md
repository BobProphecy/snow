## Models

### customer_nations

The **customer_nations** model provides insights into customer distribution across different nations. It allows businesses to analyze customer demographics, track customer acquisition by nation, and identify nations with the highest customer count. By joining the nations and customer tables based on the nation key, businesses can gain a unified view of customer and nation information. The resulting table aggregates the customer count for each nation and orders the nations based on the customer count in descending order, providing valuable insights for targeted marketing strategies, expansion plans, and customer segmentation.

### sales_report

The **sales_report** model provides insights into the top customers based on their sales performance. By aggregating customer order data and calculating the total sales amount for each customer, businesses can identify their highest revenue-generating customers. This information can be used to prioritize customer engagement, implement targeted marketing strategies, and optimize sales efforts. The query also includes additional customer details such as their full name, order count, and account information for a comprehensive view of their sales performance.
## Source / Seeds

1. **CUSTOMER**
This dataset is sourced from a SQL database and contains detailed information about customers, including their unique customer key, name, address, nation, phone number, account balance, market segment, and comments. This data is valuable for analyzing customer behavior, identifying market segments, and developing targeted marketing strategies. It can also be used to evaluate customer satisfaction and loyalty, as well as to track customer interactions and preferences over time.

2. **HW_ORDERS**
This dataset, named HW_ORDERS, does not have a specified format. It consists of various attributes such as ORDER_ID, CUSTOMER_ID, ORDER_STATUS, ORDER_CATEGORY, ORDER_DATE, and AMOUNT. These attributes provide valuable information about customer orders, including order details, order status, order category, order date, and order amount. This dataset is essential for analyzing and understanding customer purchasing behavior, tracking order status, and evaluating sales performance. It can be used for various data analysis tasks, including customer segmentation, trend analysis, and performance evaluation.

3. **HW_CUSTOMERS**
This dataset does not have a specific format mentioned. It represents information about customers in a hardware store. It includes details such as customer ID, first name, last name, phone number, email address, country code, account open date, and account flags. This dataset is valuable for analyzing customer behavior, identifying customer preferences, and monitoring account activity. It can be used for various data-driven tasks, including customer segmentation, personalized marketing strategies, and fraud detection.

4. **nations**
This dataset contains information about different nations. It includes attributes such as nation key, nation name, region key, and a comment. This dataset is not in any specific format and can be used for various analytical purposes, such as studying regional patterns, analyzing comments, and understanding the relationships between nations and regions.

5. **raw_customers**
This dataset contains raw customer data with various attributes such as customer ID

## Jobs

1. **EmployeeTableRefreshJob**

The **EmployeeTableRefreshJob** is a scheduled task running on the "dev_sql_db" fabric. This job is responsible for refreshing the Employee table in Databricks. It ensures that the table is updated with the latest information regarding new employees and any potential attrition. By executing this job, we maintain the accuracy of our employee data, enabling effective human resource management and informed decision-making.

2. **CustomerDataUpload**

The **CustomerDataUpload** job facilitates reporting by uploading customer data related to expenses and purchases to Databricks. This job streamlines the process of generating reports and analyzing customer interactions. By transferring this information seamlessly, we gain valuable insights into customer behavior and enhance our understanding of our customer base. This job supports data-driven decision-making, enabling us to make informed business decisions.