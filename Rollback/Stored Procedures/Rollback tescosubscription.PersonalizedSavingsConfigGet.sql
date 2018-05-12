/*

	Author:			Robin
	Date created:	14-Aug-2013
	Purpose:		Rollback Procedure [tescosubscription].[PersonalizedSavingsConfigGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[PersonalizedSavingsConfigGet]

		IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] does not exist.'
	END
GO
