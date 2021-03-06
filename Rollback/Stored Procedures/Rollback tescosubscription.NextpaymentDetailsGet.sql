USE TescoSubscription
GO

/*
 TYPE           : Rollback Script  
 NAME           : Procedure [tescosubscription].[NextpaymentDetailsGet]   
 AUTHOR         : Robin  
 DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [tescosubscription].[NextpaymentDetailsGet]
 DATE WRITTEN   : 7/April/2014                   
 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[NextpaymentDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[NextpaymentDetailsGet] 

		IF OBJECT_ID(N'[tescosubscription].[NextpaymentDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[NextpaymentDetailsGet]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[NextpaymentDetailsGet]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[NextpaymentDetailsGet]  does not exist.'
	END
GO