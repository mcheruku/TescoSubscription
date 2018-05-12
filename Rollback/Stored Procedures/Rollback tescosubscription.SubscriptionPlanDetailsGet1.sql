/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Purpose:		Rollback Procedure [tescosubscription].[subscriptionPlanDetailsGet1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[subscriptionPlanDetailsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[subscriptionPlanDetailsGet1]

		IF OBJECT_ID(N'[tescosubscription].[subscriptionPlanDetailsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[subscriptionPlanDetailsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[subscriptionPlanDetailsGet1] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[subscriptionPlanDetailsGet1] does not exist.'
	END
GO
