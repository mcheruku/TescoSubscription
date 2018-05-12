USE [Utilities]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Backup SCRIPT 
** NAME           : Backup for premigration rollin script 
** IMPACT	      : Used to rollback premigration rollin script	 
** AUTHOR         : Robin  
** DATE WRITTEN   : 6th March 2014                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************
*/
-- Creating the backup Table
-- ADD ur initial and date at the tables end
CREATE TABLE [dbo].[TescoSubscriptionCustomerSubscriptionRJ14032014](
	[CustomerSubscriptionID] [BIGINT] NOT NULL,
 	[SubscriptionPlanID] [INT] NOT NULL,
	[SubscriptionStatus] [TINYINT] NOT NULL,
	[SwitchTo] [INT] NULL,
	[MigrationPlanID] [INT]NULL,
 CONSTRAINT [PK_CustomerSubscriptionBackup] PRIMARY KEY CLUSTERED 
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
	   ,@Active            TINYINT
	   ,@PendingStop       TINYINT
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
       ,@Active = 8
       ,@PendingStop = 11
       ,@Suspended = 7

--  Inserting values into the backup table
--  Change the table name as mentioned above
INSERT INTO [dbo].[TescoSubscriptionCustomerSubscriptionRJ14032014]-- backup table for rollback
         (CustomerSubscriptionID  
	     ,SubscriptionPlanID 
	     ,SubscriptionStatus 
	     ,SwitchTo  
	     ,MigrationPlanID)
         (SELECT     [CustomerSubscriptionID]
           ,[SubscriptionPlanID]
           ,[SubscriptionStatus]
           ,[SwitchTo]
           ,CASE 
             WHEN SubscriptionStatus IN (@Active,@Suspended) AND SwitchTo is null
             AND SubscriptionPlanID IN (@3MonthsUpfront,@3MonthsMonthlyUpfrontPlan,@6MonthsUpfront) THEN @6MonthsPayMonthlyUfrontMigration

             WHEN SubscriptionStatus IN (@Active,@Suspended) AND SwitchTo IN (@3MonthsUpfront,@3MonthsMonthlyUpfrontPlan,@6MonthsUpfront) 
             AND SubscriptionPlanID = @6MonthsPayMonthlyUfrontMigration THEN NULL

             WHEN SubscriptionStatus IN (@Active,@Suspended) AND SwitchTo IN (@3MonthsUpfront,@3MonthsMonthlyUpfrontPlan,@6MonthsUpfront) 
             AND SubscriptionPlanID <> @6MonthsPayMonthlyUfrontMigration THEN @6MonthsPayMonthlyUfrontMigration

             WHEN SubscriptionStatus IN (@Active,@Suspended) AND SwitchTo is NULL             
             AND SubscriptionPlanID IN (@3MonthsMidWeekUpfront,@3MonthsMidWeekMonthly,@6MonthsMidweekUpfront) THEN @6MonthsMidWeekMonthlyMigration

             WHEN SubscriptionStatus IN (@Active,@Suspended) AND SwitchTo IN (@3MonthsMidWeekUpfront,@3MonthsMidWeekMonthly,@6MonthsMidweekUpfront) 
             AND SubscriptionPlanID = @6MonthsMidWeekMonthlyMigration THEN NULL

             WHEN SubscriptionStatus IN (@Active,@Suspended) AND SwitchTo IN (@3MonthsMidWeekUpfront,@3MonthsMidWeekMonthly,@6MonthsMidweekUpfront) 
             AND SubscriptionPlanID <> @6MonthsMidWeekMonthlyMigration THEN @6MonthsMidWeekMonthlyMigration

             WHEN SubscriptionStatus IN (@PendingStop) AND SwitchTo IN (@3MonthsUpfront,@3MonthsMonthlyUpfrontPlan,@6MonthsUpfront) 
             THEN  @6MonthsPayMonthlyUfrontMigration

             WHEN SubscriptionStatus IN (@PendingStop) AND SwitchTo IN (@3MonthsMidWeekUpfront,@3MonthsMidWeekMonthly,@6MonthsMidweekUpfront) 
             THEN @6MonthsMidWeekMonthlyMigration

             ELSE
	             SwitchTo
             END AS MigrationPlanID 
             FROM TescoSubscription.TescoSubscription.CustomerSubscription CS WITH (NOLOCK)
             WHERE SubscriptionStatus IN (@Active,@PendingStop,@Suspended))


