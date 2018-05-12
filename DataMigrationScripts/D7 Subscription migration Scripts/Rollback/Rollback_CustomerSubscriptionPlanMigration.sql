--Roll Back script
/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT 
** NAME           : Rollback Plan Migration Script 
** IMPACT	      : Will impact Tescosubscription.CustomerSubscription and Tescosubscription.CustomerSubscriptionSwithHistory	 
** AUTHOR         : Robin  
** DESCRIPTION    : This script will rollback the switchto column to plans like before for above mentioned table.
** DATE WRITTEN   : 6th March 2014                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************
*/
USE TescoSubscription
GO
DECLARE
   @CurrentDate DATETIME

SELECT 
  @CurrentDate = GETUTCDATE()
 
SET NOCOUNT ON
-- Creating a temporary table

  CREATE TABLE #TempSubscriptionMigrationRollback
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

-- Inserting values into temp table

  INSERT INTO #TempSubscriptionMigrationRollback 
          (CustomerSubscriptionID
          ,SubscriptionPlanID
          ,SubscriptionStatus
          ,SwitchTo
          ,MigrationPlanID)
          (SELECT [CustomerSubscriptionID]
          ,[SubscriptionPlanID]
          ,[SubscriptionStatus] 
          ,[SwitchTo]
          ,[MigrationPlanID]
          FROM [Utilities].[dbo].[TescoSubscriptionCustomerSubscriptionRJ14032014])--Need to replace with utility table
    
  PRINT 'INSERTED - ' + CONVERT(VARCHAR(10),@@ROWCOUNT) + ' record(s) into Temporory table'


BEGIN TRY

      BEGIN TRANSACTION
-- Rollback the SwitchTo From the backup

		 UPDATE  CS 
		 SET CS.SwitchTo = MG.SwitchTo
		   ,CS.UTCUpdatedDateTime = @CurrentDate
		 FROM TescoSubscription.CustomerSubscription CS
		 INNER JOIN #TempSubscriptionMigrationRollback MG 
		 ON CS.CustomerSubscriptionID = MG.CustomerSubscriptionID   
	    
    PRINT 'Roll back Migration - ' + CONVERT(varchar(10),@@ROWCOUNT) + ' SwitchTo record(s) into [TescoSubscription].[CustomerSubscription]'

-- Insert a cancelled record for all the failed migrationID	
	     DELETE CS 
	     FROM TescoSubscription.CustomerSubscriptionSwitchHistory cs
	     INNER JOIN #TempSubscriptionMigrationRollback OLDCS
	     ON CS.CustomerSubscriptionId = OLDCS.CustomerSubscriptionId
	     WHERE SwitchOrigin is null and SwitchStatus in (17,18)--InitiatedSwitch=17, CancalledSwitch=18
	 
    PRINT 'DELETED - ' + CONVERT(varchar(10), @@ROWCOUNT) + ' record(s) into [TescoSubscription].[CustomerSubscriptionSwitchHistory]'

     COMMIT TRANSACTION

END TRY

BEGIN CATCH
		SELECT 
		ERROR_NUMBER()																AS ERRORNUMBER,
		ERROR_SEVERITY()															AS ERRORSEVERITY,
		ERROR_STATE()																AS ERRORSTATE,
		ERROR_LINE()																AS ERRORLINE,
		ERROR_MESSAGE()																AS ERRORMESSAGE;

        ROLLBACK TRANSACTION			
		
		PRINT 'An error has occurred while for data Rollback: '+ERROR_MESSAGE()

END CATCH

DROP TABLE #TempSubscriptionMigrationRollback
  

