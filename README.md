# Project 1 for Team 7.

  Project 1 Description/Task:

    "Your task is to make a PostgreSQL database about [ the Senate, and
    possibly the House of Representatives ] of the United States, of course." --- Professor.

  Repo File Architecture:

    DataEntriesANDTestCases:
      Contains the data entries and test cases; both are SQL files. The contents:
        project1TestCases.sql --Distinct cases that ensure the schema objects work as intended.
        senate_house_data_entries.sql --The data entries which were required for Project 1.

    DatabaseSchema:
      Contains the database (main) schema. It also includes the EDR model. The contents:
        Project1_Schema.sql --The database schema (required for Project 1).
        project_1_350.erd.json --The EDR model (required for Project 1).

    Functions:
      Contains the SQL functions (as an SQL file) (required for Project 1). The contents:
        CountBillsSponsored.sql
        GetActiveSenators.sql
        GetCommitteeMembers.sql

    Triggers:
      Contains the SQL triggers (with trigger functions) (as an SQL file) (required for Project 1). The contents:
        SenatorsTrigger.sql
        SenatorsTriggerFunctions.sql
        
