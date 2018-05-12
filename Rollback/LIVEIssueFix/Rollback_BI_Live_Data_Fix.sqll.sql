--Roll Back script
/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT 
** NAME           : Rollback the data fix 
** IMPACT	      : Will impact Tescosubscription.Customerpayment 	 
** AUTHOR         : Robin  
** DESCRIPTION    : This script will rollback the UTCUpdatedDateTime value like it was before running data fix 
** DATE WRITTEN   : 26th Aug 2014                     
** ARGUMENT(S)    : NONE
*******************************************************************************************  
********************************************************************************************
*/
USE TescoSubscription
GO

SET NOCOUNT ON
-- Creating a temporary table

  CREATE TABLE #TempSubscriptionBIFixRollback
           ([CustomerPaymentID] [bigint] NOT NULL,
			[CustomerID] [bigint] NOT NULL,
			[PaymentModeID] [tinyint] NOT NULL,
			[IsActive] [bit] NOT NULL,
			[IsFirstPaymentDue] [bit] NOT NULL,
			[UTCCreatedDateTime] [datetime] NOT NULL ,
			[UTCUpdatedDateTime] [datetime] NOT NULL )

-- Inserting values into temp table

  INSERT INTO #TempSubscriptionBIFixRollback 
          ([CustomerPaymentID]
          ,[CustomerID]
          ,[PaymentModeID]
          ,[IsActive]
          ,[IsFirstPaymentDue]
          ,[UTCCreatedDateTime]
          ,[UTCUpdatedDateTime])
          (SELECT [CustomerPaymentID]
          ,[CustomerID]
          ,[PaymentModeID]
          ,[IsActive]
          ,[IsFirstPaymentDue]
          ,[UTCCreatedDateTime]
          ,[UTCUpdatedDateTime]
          FROM [Utilities].[dbo].[TescoSubscriptionCustomerPaymentRJ14032014]
          WHERE PaymentModeID = 2
	      AND IsActive = 0
	      AND UTCCreatedDateTime = UTCUpdatedDateTime)--Need to replace with utility table
    
  PRINT 'INSERTED - ' + CONVERT(VARCHAR(10),@@ROWCOUNT) + ' record(s) into Temporory table'


BEGIN TRY

      BEGIN TRANSACTION
-- Rollback the SwitchTo From the backup

		 UPDATE  CP 
		 SET CP.[UTCUpdatedDateTime] = MG.[UTCUpdatedDateTime]
		 FROM TescoSubscription.CustomerPayment CP
		 INNER JOIN #TempSubscriptionBIFixRollback MG 
		 ON CP.[CustomerPaymentID] = MG.[CustomerPaymentID]   
	    
    PRINT 'Roll back Migration - ' + CONVERT(varchar(10),@@ROWCOUNT) + ' UTCUpdatedDateTime record(s) into [TescoSubscription].[CustomerPayment]'


	 
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

DROP TABLE #TempSubscriptionBIFixRollback
  
 