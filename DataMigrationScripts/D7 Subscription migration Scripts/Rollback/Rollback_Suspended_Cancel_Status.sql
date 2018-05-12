--Roll Back script
/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT 
** NAME           : Rollback Plan Migration Script 
** IMPACT	      : Will impact Tescosubscription.CustomerSubscription,Tescosubscription.CustomerSubscriptionSwithHistory and Tescosubscription.CustomerSubscriptionHistory
** AUTHOR         : Robin  
** DESCRIPTION    : This script will rollback the switchto column to plans like before for above mentioned table.
** DATE WRITTEN   : 25th April 2014                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************
*/
USE TescoSubscription
GO
DECLARE
   @CurrentDate DATETIME,
   @Cancelled   TINYINT
   

SELECT 
  @CurrentDate = GETUTCDATE(),
  @Cancelled = 9
 
SET NOCOUNT ON
-- Creating a temporary table

  DECLARE
       @TempSuspendedSubscription  TABLE (CustomerSubscriptionID BIGINT ,SubscriptionPlanID INT ,SubscriptionStatus TINYINT,SwitchTo INT,SubscriptionHistoryID BIGINT)

-- Inserting values into temp table

  INSERT INTO @TempSuspendedSubscription 
          (CustomerSubscriptionID
          ,SubscriptionPlanID
          ,SubscriptionStatus
          ,SwitchTo
          ,SubscriptionHistoryID
           )
          (SELECT [CustomerSubscriptionID]
          ,[SubscriptionPlanID]
          ,[SubscriptionStatus] 
          ,[SwitchTo]
          ,SubscriptionHistoryID
          FROM [Utilities].[dbo].[TescoSubscriptionCustomerSubscriptionRJ14032014])--Need to replace with utility table
    
  PRINT 'INSERTED - ' + CONVERT(VARCHAR(10),@@ROWCOUNT) + ' record(s) into Temporory table'


BEGIN TRY

      BEGIN TRANSACTION
-- Rollback the SwitchTo From the backup

		 UPDATE  CS 
		 SET CS.SubscriptionStatus = MG.SubscriptionStatus
		   ,CS.UTCUpdatedDateTime = @CurrentDate
		 FROM TescoSubscription.CustomerSubscription CS
		 INNER JOIN @TempSuspendedSubscription MG 
		 ON CS.CustomerSubscriptionID = MG.CustomerSubscriptionID  
          
	    
    PRINT 'Roll back Migration - ' + CONVERT(VARCHAR(10),@@ROWCOUNT) + ' SwitchTo record(s) into [TescoSubscription].[CustomerSubscription]'

-- Rolback Subscription Status From CustomerSubcriptionHistory
         
      DELETE SH 
	     FROM TescoSubscription.CustomerSubscriptionHistory SH
	     INNER JOIN @TempSuspendedSubscription TS
	     ON SH.CustomerSubscriptionId = TS.CustomerSubscriptionId
	     WHERE SH.SubscriptionHistoryID > TS.SubscriptionHistoryID
         AND SH.SubscriptionStatus = @Cancelled
    PRINT 'DELETED - '+ CONVERT(VARCHAR(10), @@ROWCOUNT) + ' record(s) into [TescoSubscription].[CustomerSubscriptionHistory]'
      
-- Insert a cancelled record for all the failed migrationID	
	     DELETE CS 
	     FROM TescoSubscription.CustomerSubscriptionSwitchHistory CS
	     INNER JOIN @TempSuspendedSubscription OLDCS
	     ON CS.CustomerSubscriptionId = OLDCS.CustomerSubscriptionId
         AND CONVERT(VARCHAR(10),UTCRequestedDateTime,112) = CONVERT(VARCHAR(10),@CurrentDate,112)
	     WHERE SwitchOrigin IS NULL and SwitchStatus = 18
	 
    PRINT 'DELETED - ' + CONVERT(VARCHAR(10), @@ROWCOUNT) + ' record(s) into [TescoSubscription].[CustomerSubscriptionSwitchHistory]'

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

 


 