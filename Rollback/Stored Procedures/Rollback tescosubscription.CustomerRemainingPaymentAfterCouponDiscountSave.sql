USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		sChange Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountSave]  does not exist.'
	END
GO