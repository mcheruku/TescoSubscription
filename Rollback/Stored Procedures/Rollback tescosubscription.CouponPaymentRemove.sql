USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [tescosubscription].[CouponPaymentRemove]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [tescosubscription].[CouponPaymentRemove]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CouponPaymentRemove]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CouponPaymentRemove] 

		IF OBJECT_ID(N'[tescosubscription].[CouponPaymentRemove]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CouponPaymentRemove]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CouponPaymentRemove]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CouponPaymentRemove]  does not exist.'
	END
GO