/*

	Author:			Saritha Kommineni
	Date created:	26-Aug-2011
	Purpose:		Rollback Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionStopStatusUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionStopStatusUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionStopStatusUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerSubscriptionStopStatusUpdate] does not exist.'
	END
GO
