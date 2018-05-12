/*
	Author:		 Manjunathan Raman
	Create date: 25/10/2012
	Description: Fix for Customers with status 15

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
-- Get All the customers and their details whose subs status is 15
INSERT INTO @Customer (CustomerSubscriptionID, SubscriptionStatus, Remarks )
SELECT      CustomerSubscriptionID
            ,9 AS 'SubscriptionStatus'
            ,'Cancel through backend script' AS Remarks
FROM  tescosubscription.CustomerSubscription CS
WHERE CS.SubscriptionStatus = 15 

BEGIN TRY
      BEGIN TRAN
--    Insert into CustomerSubscriptionHistory table
      INSERT INTO tescosubscription.CustomerSubscriptionHistory
                                    (
                                    CustomerSubscriptionID,
                                    SubscriptionStatus,
                                    Remarks                             
                                    )
      SELECT * FROM @Customer
--    Update Customer Subsctiption
      UPDATE CS
            SET 
                  CustomerPlanEndDate=GETDATE()
                  ,SubscriptionStatus=9
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
