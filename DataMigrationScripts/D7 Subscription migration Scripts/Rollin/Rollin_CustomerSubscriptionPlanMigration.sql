--Roll in script

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLIN SCRIPT 
** NAME           : Plan Migration Script 
** IMPACT	      : Will impact Tescosubscription.CustomerSubscription and Tescosubscription.CustomerSubscriptionSwithHistory	 
** AUTHOR         : Robin  
** DESCRIPTION    : This script will rollin the switchto column to plans which will be active for above mentioned table.
** DATE WRITTEN   : 6th March 2014                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************
*/

USE TescoSubscription
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
	   ,@SwitchInitiated   TINYINT
	   ,@SubscriptionsMigrated INT
	   ,@HistoryInserted    INT
	   ,@InsertTemptable    INT
	   ,@SwitchCancelled    INT
	   ,@SwitchcancelledStatus  INT


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
       ,@SwitchInitiated = 17
       ,@SwitchCancelled = 18

SET NOCOUNT ON

-- Creating a temp table

	 CREATE  TABLE #TempSubscriptionMigration
	  (CustomerSubscriptionID BIGINT
	  ,SubscriptionPlanID INT
	  ,SubscriptionStatus INT
	  ,SwitchTo INT
	  ,MigrationPlanID INT
	  ,CONSTRAINT [PK_CustomerSubscriptionID] PRIMARY KEY CLUSTERED 
	  (
	  [CustomerSubscriptionID] ASC
	  )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	  ) ON [PRIMARY]

-- Inserting the value into the temp table with extra column Migration PlanID

INSERT INTO #TempSubscriptionMigration (CustomerSubscriptionID,SubscriptionPlanID,SubscriptionStatus,SwitchTo,MigrationPlanID)

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
             FROM TescoSubscription.CustomerSubscription CS WITH (NOLOCK)
             WHERE SubscriptionStatus IN (@Active,@PendingStop,@Suspended)
            )
    SET @InsertTemptable = @@ROWCOUNT
    PRINT 'INSERTED - ' + CONVERT(varchar(10),@InsertTemptable) + ' record(s) into Temporory table'

BEGIN TRY
      BEGIN TRANSACTION

    -- Updating the CustomerSubscription table SwitchTo Column     
       UPDATE  CS 
       SET CS.SwitchTo = MG.MigrationPlanID
         ,CS.UTCUpdatedDateTime = @CurrentDate
      FROM TescoSubscription.CustomerSubscription CS
      INNER JOIN #TempSubscriptionMigration MG 
      ON CS.CustomerSubscriptionID = MG.CustomerSubscriptionID
      WHERE ISNULL(CS.SwitchTo,0) <> ISNULL(MG.MigrationPlanID,0)  

      SET @SubscriptionsMigrated = @@ROWCOUNT

      PRINT 'MIGRATED - ' + CONVERT(varchar(10),@SubscriptionsMigrated) + ' SwitchTo record(s) into [TescoSubscription].[CustomerSubscription]'

     -- Cancelling the Switch in Switch History Table for decommisioned plans 

      INSERT INTO TescoSubscription.CustomerSubscriptionSwitchHistory
      (CustomerSubscriptionID
      ,SwitchTo
      ,SwitchStatus
      ,SwitchOrigin)
      (SELECT CustomerSubscriptionID
      ,SwitchTo
      ,@SwitchCancelled
      ,NULL
       FROM #TempSubscriptionMigration
       WHERE SwitchTo IS NOT NULL
       AND SwitchTo NOT IN (@6MonthsMidWeekMonthlyMigration,@6MonthsPayMonthlyUfrontMigration))-- No switch Cancelation for these plans 

     SET @SwitchcancelledStatus = @@ROWCOUNT

     PRINT 'INSERTED - ' + CONVERT(varchar(10), @SwitchcancelledStatus) + ' Switch cancelled record(s) into [TescoSubscription].[CustomerSubscriptionSwitchHistory]'

	-- Inserting The new records into switchhistory table with initated status

      INSERT INTO TescoSubscription.CustomerSubscriptionSwitchHistory
      (CustomerSubscriptionID
      ,SwitchTo
      ,SwitchStatus
      ,SwitchOrigin)
      (
		SELECT 
			CustomerSubscriptionID
			,MigrationPlanID
			,@SwitchInitiated
			,NULL
      FROM #TempSubscriptionMigration
      WHERE ((MigrationPlanID IS NOT NULL AND SubscriptionStatus = @PendingStop AND ISNULL(SwitchTo,0) <> ISNULL(MigrationPlanID,0))
			OR (MigrationPlanID IS NOT NULL AND SubscriptionStatus in(8,7) AND ISNULL(SwitchTo,0) <> ISNULL(MigrationPlanID,0))))
 

      SET @HistoryInserted = @@ROWCOUNT

      PRINT 'INSERTED - ' + CONVERT(varchar(10), @HistoryInserted) + ' Switch Initiated record(s) into [TescoSubscription].[CustomerSubscriptionSwitchHistory]'

     COMMIT TRANSACTION

END TRY

BEGIN CATCH
        SELECT 
        ERROR_NUMBER()                                                                                              AS ERRORNUMBER,
        ERROR_SEVERITY()                                                                                            AS ERRORSEVERITY,
        ERROR_STATE()                                                                                               AS ERRORSTATE,
        ERROR_LINE()                                                                                                AS ERRORLINE,
        ERROR_MESSAGE()                                                                                             AS ERRORMESSAGE; 
        ROLLBACK TRANSACTION                         
        PRINT 'An error has occurred while migrating the data: '+ERROR_MESSAGE()
END CATCH 


-- Droping the table after migration
DROP TABLE #TempSubscriptionMigration

