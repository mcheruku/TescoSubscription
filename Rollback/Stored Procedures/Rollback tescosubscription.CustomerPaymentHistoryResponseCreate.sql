/*

	Author:			Saritha Kommineni
	Date created:	06-Jan-2012
	Purpose:		Rollback Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerPaymentHistoryResponseCreate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponseCreate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerPaymentHistoryResponseCreate] does not exist.'
	END
GO
