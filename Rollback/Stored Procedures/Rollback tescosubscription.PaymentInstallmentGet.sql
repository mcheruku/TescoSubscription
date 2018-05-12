/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Purpose:		Rollback Procedure [tescosubscription].[PaymentInstallmentGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PaymentInstallmentGet]

		IF OBJECT_ID(N'[tescosubscription].[PaymentInstallmentGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PaymentInstallmentGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PaymentInstallmentGet] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[PaymentInstallmentGet] does not exist.'
	END
GO
