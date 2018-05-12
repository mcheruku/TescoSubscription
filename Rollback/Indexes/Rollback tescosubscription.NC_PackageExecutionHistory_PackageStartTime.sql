/*
      Created By:       Saritha Kommineni
      Date created:     10 May 2012
      Purpose:          ROLLBACK script for NC_PackageExecutionHistory_PackageStartTime
 
      --Modifications History--
      Changed On	 Changed By        Defect            Description
      
      
*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.PackageExecutionHistory', N'U') 
AND [name] = N'NC_PackageExecutionHistory_PackageStartTime')
            BEGIN
                        DROP INDEX tescosubscription.PackageExecutionHistory.[NC_PackageExecutionHistory_PackageStartTime]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.PackageExecutionHistory', N'U') 
                                                            AND [name] = N'NC_PackageExecutionHistory_PackageStartTime')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_PackageExecutionHistory_PackageStartTime] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_PackageExecutionHistory_PackageStartTime] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_PackageExecutionHistory_PackageStartTime] does not exist.'
            END
GO