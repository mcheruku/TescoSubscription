USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [tescosubscription].[SetCustomerPaymentCouponUsed]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [tescosubscription].[SetCustomerPaymentCouponUsed]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SetCustomerPaymentCouponUsed] 

		IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed]  does not exist.'
	END
GO