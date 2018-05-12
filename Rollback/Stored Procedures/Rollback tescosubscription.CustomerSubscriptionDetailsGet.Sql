/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Procedure [tescosubscription].[CustomerSubscriptionDetailsGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionDetailsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionDetailsGet] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerSubscriptionDetailsGet] does not exist.'
	END
GO
