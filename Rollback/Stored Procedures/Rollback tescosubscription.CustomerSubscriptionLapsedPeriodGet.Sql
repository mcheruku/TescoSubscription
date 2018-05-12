/*

	Author:			Manjunathan Raman
	Date created:	10-Oct-2012
	Purpose:		Rollback Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionLapsedPeriodGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] does not exist.'
	END
GO
