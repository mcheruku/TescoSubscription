--Roll in script

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLIN SCRIPT 
** NAME           : Change Subscription Status to cancelled for Suspended Customers 
** IMPACT	      : Will impact Tescosubscription.CustomerSubscription ,CustomerSubscriptionHistory	and CustomerSubscriptionSwitchHistory
** AUTHOR         : Robin  
** DESCRIPTION    : This script will rollin to Change Subscription Status to cancelled for Suspended Customers 
** DATE WRITTEN   : 24th April 2014                     
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
	   ,@CutOffDate  VARCHAR(10)
	   ,@Suspended   TINYINT
       ,@Cancelled   TINYINT 
       ,@InsertTemptable INT 
       ,@SubscriptionsMigrated INT 
       ,@SwitchcancelledStatus INT
       ,@HistoryInserted       INT
       ,@SwitchCancelled       TINYINT

DECLARE
       @TempSuspendedSubscription  TABLE (CustomerSubscriptionID BIGINT ,SubscriptionPlanID INT ,SubscriptionStatus TINYINT,SwitchTo INT, SubscriptionHistoryID BIGINT)

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
       ,@Cancelled = 9
       ,@SwitchCancelled =18

SET NOCOUNT ON

INSERT INTO @TempSuspendedSubscription (CustomerSubscriptionID,SubscriptionPlanID,SubscriptionStatus,SwitchTo,SubscriptionHistoryID)
(SELECT CS.[CustomerSubscriptionID]
           ,CS.[SubscriptionPlanID]
           ,CS.[SubscriptionStatus]
           ,CS.[SwitchTo]
           ,SH.SubscriptionHistoryID
            FROM Tescosubscription.Tescosubscription.CustomerSubscription CS
            INNER JOIN (
            SELECT CustomerSubscriptionID
                  ,SubscriptionHistoryID
                  ,MAX(UTCCreatedDateTime) UTCCreatedDateTime
                  ,SubscriptionStatus
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
                                        -- (1,2,5,6,7,9)
            AND CS.SwitchTo IN (@6MonthsPayMonthlyUfrontMigration,@6MonthsMidWeekMonthlyMigration))--(8,10)) 
    SET @InsertTemptable = @@ROWCOUNT
    PRINT 'INSERTED - ' + CONVERT(varchar(10),@InsertTemptable) + ' record(s) into Temporory table'

BEGIN TRY
      BEGIN TRANSACTION

    -- Updating the CustomerSubscription table SwitchTo Column     
       UPDATE  CS 
       SET CS.SubscriptionStatus = @Cancelled
         ,CS.UTCUpdatedDateTime = @CurrentDate
         ,CS.CustomerPlanEndDate = @CurrentDate
       FROM TescoSubscription.CustomerSubscription CS
       INNER JOIN @TempSuspendedSubscription MG 
       ON CS.CustomerSubscriptionID = MG.CustomerSubscriptionID
       WHERE CS.SubscriptionStatus = @Suspended
     

      SET @SubscriptionsMigrated = @@ROWCOUNT

      PRINT 'Cancelled - ' + CONVERT(varchar(10),@SubscriptionsMigrated) + ' Subscription record(s) from [TescoSubscription].[CustomerSubscription]'

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
       FROM @TempSuspendedSubscription
       WHERE SwitchTo IS NOT NULL)
       
     SET @SwitchcancelledStatus = @@ROWCOUNT

     PRINT 'INSERTED - ' + CONVERT(VARCHAR(10), @SwitchcancelledStatus) + ' Switch cancelled record(s) into [TescoSubscription].[CustomerSubscriptionSwitchHistory]'

	-- Inserting The new records into switchhistory table with initated status

      INSERT INTO TescoSubscription.CustomerSubscriptionHistory
      (CustomerSubscriptionID
      ,SubscriptionStatus
      ,UTCCreatedDateTime
      ,Remarks)
      (SELECT 
	   CustomerSubscriptionID
	  ,@Cancelled
	  ,@CurrentDate
	  ,'Cancelled automatically – previously a suspended plan'
      FROM @TempSuspendedSubscription)
      

      SET @HistoryInserted = @@ROWCOUNT

      PRINT 'INSERTED - ' + CONVERT(varchar(10), @HistoryInserted) + ' Switch Initiated record(s) into [TescoSubscription].[CustomerSubscriptionHistory]'

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


 


 



