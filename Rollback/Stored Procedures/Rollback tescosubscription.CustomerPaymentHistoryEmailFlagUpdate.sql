/*

	Author:			Saritha Kommineni
	Date created:	13-Sep-2011
	Purpose:		Rollback Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerPaymentHistoryEmailFlagUpdate] does not exist.'
	END
GO
