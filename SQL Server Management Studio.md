In this project, I use SQL Server Management Studio (SSMS) to query the data and perform data analytics.

The Covid-19 data downloaded from the Victorian Department of Health is used. (attached in the Data folder in the main branch)
In SSMS, create a new database named 'CovidCasesByLGA'. Load the downloaded '.csv' data and build a database.

Open a new query in SSMA and use the 'CovidCasesByLGA' for query.
1. Query all from the database. Use scroll down to inspect it. The database has two columns 'diagnosis_date' and 'Localgovermentarea'. It include both 2020 and 2021 data.
![image](https://user-images.githubusercontent.com/76986018/144549914-ed301b31-865f-457a-94dd-82c86adb8cf5.png)
2. Use 'Order by' to arrange the data from earliest date. We see the earliest reported Covid case in Victoria is 2020-01-25 at Monash LGA. The last reported data in this database is 2021-11-27
![image](https://user-images.githubusercontent.com/76986018/144551446-bdfa8bd0-4773-4dc3-8f3f-35da4363b912.png)
3. Query the total count of data in this database. There are in total 119815 inputs in the database.
![image](https://user-images.githubusercontent.com/76986018/144551704-5799be97-3909-4497-8ca9-cb8236afaea6.png)
4. Use 'IS NULL' to check whether any empty input exists. It returns nothing after the query (replace diagnosis_date with Localgovernmentarea and query again), meaning there's no null value in both column. It means there're a total 119815 reported covid cases from 2020-01-25 to 2021-11-27 in Victoria.
![image](https://user-images.githubusercontent.com/76986018/144552016-e55fd2d6-84a9-4176-8710-7f95c8ec09d5.png)
5. 





