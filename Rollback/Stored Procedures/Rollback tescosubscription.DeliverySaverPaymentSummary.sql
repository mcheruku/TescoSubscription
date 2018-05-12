/*

	Author:			Saritha Kommineni
	Date created:	18-Jan-2012
	Purpose:		Rollback Procedure [tescosubscription].[DeliverySaverPaymentSummary] 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPaymentSummary]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[DeliverySaverPaymentSummary]

		IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPaymentSummary]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPaymentSummary] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPaymentSummary] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[DeliverySaverPaymentSummary] does not exist.'
	END
GO
