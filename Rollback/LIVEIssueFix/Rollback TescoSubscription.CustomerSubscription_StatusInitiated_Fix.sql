/*
	Author:		 Manjunathan Raman
	Create date: 25/10/2012
	Description: Rollback Fix for Customers with status 15

		--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description



*/

USE TESCOSubscription
GO 

DECLARE @Customer TABLE
(
      CustomerSubscriptionID  BIGINT
      ,SubscriptionStatus           INT
      ,Remarks                      VARCHAR(250)
)
-- Get All the customers which were updated with DB Fix
INSERT INTO @Customer (CustomerSubscriptionID, SubscriptionStatus, Remarks )
SELECT      CustomerSubscriptionID
            ,9 AS 'SubscriptionStatus'
            ,'Cancel through backend script' AS Remarks
FROM  tescosubscription.CustomerSubscriptionHistory CSH
WHERE CSH.SubscriptionStatus = 9 AND  Remarks='Cancel through backend script'

BEGIN TRY
      BEGIN TRAN
--    DELETE FROM CustomerSubscriptionHistory table
      DELETE CSH FROM tescosubscription.CustomerSubscriptionHistory CSH
      JOIN  @Customer C ON CSH.CustomerSubscriptionID=C.CustomerSubscriptionID  
      AND  CSH.SubscriptionStatus = 9 AND  CSH.Remarks='Cancel through backend script'
      
--    Update Customer Subsctiption
      UPDATE CS
            SET 
                  CustomerPlanEndDate='9999-12-31 23:59:59.997'
                  ,SubscriptionStatus=15
                  ,UTCUpdatedDateTime=GETUTCDATE()
      FROM  tescosubscription.CustomerSubscription CS
      INNER JOIN  @Customer C ON C.CustomerSubscriptionID = CS.CustomerSubscriptionID
  
      COMMIT TRAN
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
