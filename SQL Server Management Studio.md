In this project, I use SQL Server Management Studio (SSMS) to query the data and perform data analytics.

########## This is a developing project ##########

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

5. Use 'Group by', 'Count' and 'Order by' to calculate the number of cases for each LGA. It shows the most heavility Covid infected LGAs are 'Hume','Wyndham','Casey' among others.

![image](https://user-images.githubusercontent.com/76986018/144689278-c9bc0f30-df15-481c-be9c-62dd2031581e.png)

6. These are useful information. It can help planning tailored support for the heavily impacted LGAs. Let's save this query results as 'CovidCasesByLGA_Ranking.csv'. We can use visualisation tools such as Power BI or Tableau to show the data, such as this one. It clearly shows the top 7 LGAs account for more than 50% of total Covid cases.

![image](https://user-images.githubusercontent.com/76986018/144692236-f8f7967b-0cfe-4669-8a09-f95b00f0da13.png)

7. Let's continue explore the data. Load another database 'CovidCasesBySource.csv'. Inspect the data and perform similar steps as above to understand the database. We find the new database has two columns 'diagnosis_date' and 'acquired', no null values for both columns, a total of 119815 inputs/rows, include data from 2020-01-25 to 2021-11-27.

![image](https://user-images.githubusercontent.com/76986018/144693096-864b9793-f246-4d90-a7a7-950803f57bfc.png)
![image](https://user-images.githubusercontent.com/76986018/144693066-f227aeaf-e202-4d0a-bfa6-a0af32d167fc.png)
![image](https://user-images.githubusercontent.com/76986018/144693143-35286392-91ae-43cf-8f4b-2897f5b55a4d.png)

8. Use 'Group by' to show the number of cases by acquired sources. We see the data is categorized as four 'acquired' groups, i.e. 'Contact with a confirmed case', 'Under investigation', 'Acquired in Australia, unknown source' and 'Travel overseas'.

![image](https://user-images.githubusercontent.com/76986018/144693233-f9ba9463-02b1-472a-b050-104cd2de2c36.png)
   We can pivot the table to show the acquisition source as column names, for example this one.
   
![image](https://user-images.githubusercontent.com/76986018/145142207-e26f98e9-02d4-4d43-bca7-cc8202248f48.png)

9. Let's save this query results as 'CovidCasesBySource_Ranking.csv' and use Power BI to visualize it. 

   It shows that 'Contact with confirmed case' is the highest acquisition source with a total of 66853 cases, meaning close contact or social interaction are main contributors to community transmission. 

   There are also high case numbers 'under investigation' (47023) and 'Acquired in Australia, unknown source' (4702). It shows the difficulty in identifying source of transmission or maybe the contact tracing is overwhelmed. This is an interesting notice and seems there's a change of how cases sources are reported. We will look into it further shortly.

   There're relatively small number of cases acquired from 'Travel overseas' (1237). There were border control measures in Australia since 2020 which seems to help reduce imported cases. It would also be interesting to investigate this.

![image](https://user-images.githubusercontent.com/76986018/144707154-d42881fe-038f-4506-8ae1-b09666f3ec77.png)

10. The acquired sources seem to have a relation with diagnosis_date as well. Let's have a look. Query the number of cases by acquisition source, 'Group by' diagnosis date'. It produces a table with two columns, 'diagnosis_date' and 'NumberofCases' for example.

![image](https://user-images.githubusercontent.com/76986018/144707983-1de4ca25-bdc1-4ba1-9726-33f0ff2aadac.png)

11. It would be good to have query results from each acquisition source 'JOIN' to be a mega table, including five columns which are 'diagnosis_date' and four acquisition sources. Let's see how to achieve that.

    We use WITH clause to define temporary relations before we query the final columns needed. 
    
    In the WITH clause, we first define a table includes one column 'diagnosis_date' with consecutive dates from '2020-01-25' to '2021-11-27'. This is created as the 'diagnosis_date' quried from the raw data may not be consecutive days.
    
    In the WITH clause, we then query the 'diagnosis_date' and 'Count of cases' for each acquisition source.
    
    Outside the WITH clause, we query the consecutive 'diagnosis_date' and 'Count of cases' from each acquisition temporary tables, using 'LEFT JOIN' to join the tables.
    Use ISNULL(column_name,0) to change all 'NULL' values in the selected column to be 0.
    
![image](https://user-images.githubusercontent.com/76986018/145184893-a3d5691d-fc83-4734-baba-e607b9b0e998.png)
![image](https://user-images.githubusercontent.com/76986018/145183781-dd7da660-6429-4e2d-99de-91e3f1c7aeb5.png)
![image](https://user-images.githubusercontent.com/76986018/145183889-8640b153-ff08-474c-84fa-a5cf12e16d84.png)

    We obtain the table needed! The query gives the history of Covid-19 cases for each consecutive date (from 2020-1-25 to 2021-11-27) from each acquisition source.
    Let's save this query results as 'CovidCasesBySource_all.csv'

![image](https://user-images.githubusercontent.com/76986018/145184044-1a2caf68-0641-4d55-80b6-94d4d3d2b83b.png)
...
![image](https://user-images.githubusercontent.com/76986018/145184128-67a920e4-f73c-4cf3-bd22-8945b15bdbc4.png)


12. Use Power BI to visualize the query results.

    The dependence of diagnosed cases on time for each acquisition source illutrates the development of Covid-19 in Victoria. It is a reflection of border control, domestic Covid-19 control measures and contact tracing efforts in the state.
    
    The first wave of cases is observed in the first quarter of 2020, driven by returned travelers from overseas. A peak value of 629 overseas cases is reported in March 2020, leading to strict international border controls and quarantine measures which drives the overseas cases down in the second quarter of 2020. The overseas cases remain at low level after that, due to tighten border regulations by the Victorian and the Federal government. There are some surge of cases reported from returned travellers from early 2021, possibly due to worsen Covid situations overseas because of Covid variant such as the Delta variant.
    
    The second wave of cases is observed in the third quarter of 2020, driven by community transmissions. This is seeded by overseas cases and especially leaks from hotel quarantine. Peak values of community transimission with 1937 unknown-source cases and 6542 close-contact (with a confirmed case) cases are reporeted in July 2020, leading to a stage 3 lockdown of the Victorian state. The high case number continues to August 2020, with 1358 unknown-source cases and 7009 cases close-contact cases reported, resulting in a stage 4 lockdown implemented. A sharp decrease of cases is reported in September 2020, reflecting the effect of strict Covid control measures. The lockdown of Victorian ended in the last quarter of 2020 and low level (nearly 0) Covid cases are maintained thereafter (till July-2021) due to strong contact tracing efforts and border closures.
    
    The third wave of cases is observed from July 2021, when community transimission resurges leading to another hard lockdown in Victoria. The lockdown seems to stable the case numbers, where slow increase of close-contact cases are reported in August 2021. However, some change of Covid-19 control measures start to change from September 2021, due to higher number of people get vaccinated. The community tranmission skyrockets since September 2021 shown by high case numbers 'Under investigation', 'Contact with a confirmed case' and 'Unknown source'. One interesting note is that the cases 'Under investigation' remains 0 throught the pandemic till August 2021, it shows the contact tracing capability is overwhelmed by high case numbers, giving the contact tracing team less time to trace and categorize cases (or resulting in changes of how cases are categorized). A peak of 51734 cases are reported in October, dominated by community transmission.
    
    A decline of total cases is observed in November 2021 (though the data is till 27-Nov-2021), compared to that of October 2021. This is a promissing signal, showing the potential effect of vaccination on driving cases numbers down. Both the 'Contact with a confirmed case' and 'Under investigation' cases drop from the October data, though the 'Unknown source' case number continue to increase despite its much smaller value compared with the other two. We can be cautiously optimistic based on the current data, but more time is needed to observe the Covid situation and draw a full picture. 
    
![image](https://user-images.githubusercontent.com/76986018/145303086-a26e3f61-baaf-4339-abfb-fb3f4c4cdb50.png)

![image](https://user-images.githubusercontent.com/76986018/145289649-49d7a3e8-7547-4a5e-a52f-b9e9cff7e28d.png)

(It would be interesting to study the effect of vaccination on Covid transimission in a real world scenario. The next project, stay tuned! :raised_hands:)











