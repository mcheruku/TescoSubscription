USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[RemainingPaymentSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[RemainingPaymentSave]

		IF OBJECT_ID(N'[tescosubscription].[RemainingPaymentSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[RemainingPaymentSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[RemainingPaymentSave] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[RemainingPaymentSave]
(
     @CustomerSubscriptionID BIGINT	
	,@RemainingPayment MONEY
)
AS
/*  
    Author:			Robin
	Date created:	25 Apr 2014
	Purpose:		To save the remaining payment amount into the table  tescosubscription.CustomerPaymentRemainingDetail
	Behaviour:		
	Usage:			Often/Hourly
	Called by:		Subscription Service
	WarmUP Script:	Execute [tescosubscription].[RemainingPaymentSave]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/

BEGIN

SET NOCOUNT ON;	

DECLARE
	 @errorDescription	NVARCHAR(2048)
	,@error				INT
	,@errorProcedure	SYSNAME
	,@errorLine			INT
 
    BEGIN TRY
 
		BEGIN TRANSACTION
		INSERT INTO tescosubscription.CustomerPaymentRemainingDetail
		(
			 CustomerSubscriptionId
			,PaymentRemainingAmount
		)
		VALUES
		(
		 @CustomerSubscriptionID
		,@RemainingPayment
		)

		COMMIT TRANSACTION 
		
	END TRY
	BEGIN CATCH

		 SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
					  , @error                = ERROR_NUMBER()
					  , @errorDescription     = ERROR_MESSAGE()
					  , @errorLine            = ERROR_LINE()
		 FROM  INFORMATION_SCHEMA.ROUTINES
		 WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

		 ROLLBACK TRANSACTION 
		 
		 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
	 
	END CATCH


END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[RemainingPaymentSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[RemainingPaymentSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[RemainingPaymentSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[RemainingPaymentSave] not created.',16,1)
	END
GO





