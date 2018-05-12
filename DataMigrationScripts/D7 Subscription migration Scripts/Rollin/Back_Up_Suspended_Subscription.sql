USE [Utilities]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Backup SCRIPT 
** NAME           : Backup for premigration rollin script 
** IMPACT	      : Used to rollback premigration rollin script	 
** AUTHOR         : Robin  
** DATE WRITTEN   : 25th April 2014                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************
*/
-- Creating the backup Table
-- ADD ur initial and date at the tables end
CREATE TABLE [Utilities].[dbo].[TescoSubscriptionCustomerSubscriptionRJ14032014](
	[CustomerSubscriptionID] [BIGINT] NOT NULL,
 	[SubscriptionPlanID] [INT] NOT NULL,
	[SubscriptionStatus] [TINYINT] NOT NULL,
	[SwitchTo] [INT] NULL,
    [CS_CreatedDate] DateTime NOT NULL,
    [SH_CreateDate]  DateTime NOT NULL,
    [SubscriptionHistoryID] [BIGINT]
CONSTRAINT [PK_SuspendedSubscription] PRIMARY KEY CLUSTERED 
(
	[CustomerSubscriptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
DECLARE
	    @3MonthsUpfront INT
	   ,@3MonthsMonthlyUpfrontPlan INT
	   ,@6MonthsPayMonthlyUfrontMigration INT
	   ,@3MonthsMidWeekUpfront INT
	   ,@3MonthsMidWeekMonthly INT
	   ,@6MonthsMidWeekMonthlyMigration INT
	   ,@6MonthsUpfront INT
	   ,@6MonthsMidweekUpfront INT
	   ,@CurrentDate DATETIME
	   ,@CutOffDate  VARCHAR(10)
	   ,@Suspended         TINYINT
      

SELECT  @3MonthsUpfront = 1   
       ,@6MonthsUpfront= 2
       ,@3MonthsMonthlyUpfrontPlan = 7
       ,@6MonthsPayMonthlyUfrontMigration = 8
       ,@3MonthsMidWeekUpfront = 5
       ,@6MonthsMidweekUpfront = 6
       ,@3MonthsMidWeekMonthly = 9
       ,@6MonthsMidWeekMonthlyMigration = 10
       ,@CurrentDate = GETUTCDATE()
       ,@CutOffDate = '20140422'
       ,@Suspended = 7

--  Inserting values into the backup table
--  Change the table name as mentioned above
INSERT INTO [Utilities].[dbo].[TescoSubscriptionCustomerSubscriptionRJ14032014]-- backup table for rollback
         (CustomerSubscriptionID  
	     ,SubscriptionPlanID 
	     ,SubscriptionStatus 
	     ,SwitchTo
         ,CS_CreatedDate
         ,SH_CreateDate
         ,SubscriptionHistoryID)
         (SELECT CS.[CustomerSubscriptionID]
           ,CS.[SubscriptionPlanID]
           ,CS.[SubscriptionStatus]
           ,CS.[SwitchTo]
           ,CS.[UTCCreatedDateTime]
           ,SH.[UTCCreatedDateTime]
           ,SubscriptionHistoryID
            FROM Tescosubscription.Tescosubscription.CustomerSubscription CS
            INNER JOIN (
            SELECT CustomerSubscriptionID
                  ,MAX(UTCCreatedDateTime) UTCCreatedDateTime
                  ,SubscriptionStatus
                  ,SubscriptionHistoryID
                  ,ROW_NUMBER() OVER (PARTITION BY CustomerSubscriptionID ORDER BY UTCCreatedDateTime DESC)RN
	        FROM Tescosubscription.Tescosubscription.CustomerSubscriptionHistory WITH (NOLOCK)
            WHERE SubscriptionStatus = 7
            AND CONVERT(VARCHAR(8),UTCCreatedDateTime,112)<= '20140422' --@CutOffDate
            GROUP BY CustomersubscriptionID,UTCCreatedDateTime,SubscriptionStatus,SubscriptionHistoryID)SH
            ON CS.CustomerSubscriptionID = SH.CustomerSubscriptionID
            AND CS.SubscriptionStatus = SH.SubscriptionStatus
            WHERE CS.SubscriptionStatus = 7 -- @Suspended
            AND RN = 1
            AND CS.SubscriptionPlanID IN (@3MonthsUpfront,@6MonthsUpfront,@3MonthsMidWeekUpfront,@6MonthsMidweekUpfront,@3MonthsMonthlyUpfrontPlan,@3MonthsMidWeekMonthly)
                                          --(1,2,5,6,7,9)
            AND CS.SwitchTo IN (@6MonthsPayMonthlyUfrontMigration,@6MonthsMidWeekMonthlyMigration))--(8,10)) 
            
            
 