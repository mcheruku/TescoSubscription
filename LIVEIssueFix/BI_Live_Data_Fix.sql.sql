USE TescoSubscription
GO
/*
Author: Robin
Created Date : 20th Aug 2014
Purpose: LIVE ISSUE FIX 
         To set the UTCUpdatedDateTime to currentdate so that the records get
         picked up by the data warehouse package.
Usage : Once
Server: UKTUL02SQLDB23\DB23
*/
BEGIN
BEGIN TRY
    BEGIN TRANSACTION 

	UPDATE Tescosubscription.CustomerPayment
	SET UTCUpdatedDateTime = GETUTCDATE()
	WHERE PaymentModeID = 2
	AND IsActive = 0
	AND UTCCreatedDateTime = UTCUpdatedDateTime

PRINT  'Updated ' + CONVERT(varchar(10), @@Rowcount) + ' records UTCUpdatedDateTime for Tescosubscription.CustomerPayment table '
   

    COMMIT TRANSACTION

END TRY

BEGIN CATCH
      ROLLBACK TRAN
      SELECT 'Error occured, please contact dev team with Error details'  
             , Routine_Schema  + '.' + Routine_Name AS 'errorProcedure'
             , ERROR_NUMBER() AS 'error'
             , ERROR_MESSAGE()      AS 'errorDescription'
             , ERROR_LINE()         AS 'errorLine'
      FROM  INFORMATION_SCHEMA.ROUTINES
      WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)     
END CATCH


END