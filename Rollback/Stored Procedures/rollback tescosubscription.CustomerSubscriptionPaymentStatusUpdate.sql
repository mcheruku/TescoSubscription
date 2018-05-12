/*

	Author:			Saritha Kommineni
	Date created:	13-Sep-2011
	Purpose:		Rollback Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPaymentStatusUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerSubscriptionPaymentStatusUpdate] does not exist.'
	END
GO
	