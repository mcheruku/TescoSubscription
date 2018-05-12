/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Purpose:		Rollback Procedure [tescosubscription].[subscriptionPlanDetailsGetXML]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[subscriptionPlanDetailsGetXML]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[subscriptionPlanDetailsGetXML]

		IF OBJECT_ID(N'[tescosubscription].[subscriptionPlanDetailsGetXML]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[subscriptionPlanDetailsGetXML] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[subscriptionPlanDetailsGetXML] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[subscriptionPlanDetailsGetXML] does not exist.'
	END
GO
