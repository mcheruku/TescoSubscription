USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		sChange Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] 

		IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]  does not exist.'
	END
GO