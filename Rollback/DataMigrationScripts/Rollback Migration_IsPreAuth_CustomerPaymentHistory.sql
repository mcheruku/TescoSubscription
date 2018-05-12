USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Rollback Migration Script
** NAME           : Rollback Migrate data from [tescosubscription].[CustomerPaymentHistory] to 
**                            [tescosubscription].[CustomerPaymentHistory] table into IsPreAuth Coloumn.
** AUTHOR         : Robin 
** DESCRIPTION    : This script will Rollback migrate Pre Auth Amount which is PaymentAmount(2 Pounds) from 
                    [tescosubscription].[CustomerPaymentHistory] table to 
**                            [tescosubscription].[CustomerPaymentHistory] into IsPreAuth Column which is Bollean .
** DATE WRITTEN   : 18/05/2014
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
*******************************************************************************************/
SET NOCOUNT ON
GO

BEGIN TRY

DECLARE @migrated INT, @exists INT, @actual INT

SELECT @migrated = 0, @exists = 0, @actual = 0

SELECT @actual = count(*)
FROM [tescosubscription].[CustomerPaymentHistory] PH
WHERE IsPreAuth = 1

PRINT 'PreAuth Records Expected to Rollback '+ Convert(varchar(10),@actual)

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL
BEGIN
        UPDATE PH
        SET PH.IsPreAuth = 0
        FROM [tescosubscription].[CustomerPaymentHistory] PH
        INNER JOIN [tescosubscription].[CustomerSubscription] CS
        ON CS.CustomerSubscriptionID = PH.CustomerSubscriptionID
        WHERE PH.IsPreAuth = 1
                
        SET @migrated = @@ROWCOUNT

      
        PRINT 'EXISTS - ' + CONVERT(varchar(10), @actual) + ' record(s) already existed in [tescosubscription].[CustomerPaymentHistory].'
        PRINT 'Roll-Back - ' + CONVERT(varchar(10), @migrated) + ' record(s) into IsPreAuth Column .'
        PRINT 'Rollback Completed'   
 END
      ELSE
            BEGIN
                  PRINT 'NOT EXISTS - Table [tescosubscription].[CustomerPaymentHistory] doesn''t exists.'
            END
END TRY

BEGIN CATCH
            SELECT 
            ERROR_NUMBER()                                                                                              AS ERRORNUMBER,
            ERROR_SEVERITY()                                                                                      AS ERRORSEVERITY,
            ERROR_STATE()                                                                                               AS ERRORSTATE,
            ERROR_LINE()                                                                                                AS ERRORLINE,
            ERROR_MESSAGE()                                                                                             AS ERRORMESSAGE;              
            
            PRINT 'An error has occurred while migrating the data: '+ERROR_MESSAGE()
END CATCH;



 