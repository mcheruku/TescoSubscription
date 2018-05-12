USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [tescosubscription].[CouponPaymentSave]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [tescosubscription].[CouponPaymentSave]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CouponPaymentSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CouponPaymentSave] 

		IF OBJECT_ID(N'[tescosubscription].[CouponPaymentSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CouponPaymentSave]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CouponPaymentSave]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CouponPaymentSave]  does not exist.'
	END
GO