/*

Author:     Saritha Kommineni
Created:    10 May 2012
Purpose:    Create index   [NC_PackageExecutionHistory_PackageStartTime] on [tescosubscription].[PackageExecutionHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description



*/

IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]', N'U')
                   AND   [name] = N'NC_PackageExecutionHistory_PackageStartTime') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_PackageExecutionHistory_PackageStartTime] 
                    ON [tescosubscription].[PackageExecutionHistory] ([PackageStartTime] ASC)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U')
                                 AND   [name] = N'NC_PackageExecutionHistory_PackageStartTime')
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_PackageExecutionHistory_PackageStartTime] created.'
                            END
                       ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_PackageExecutionHistory_PackageStartTime] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_PackageExecutionHistory_PackageStartTime] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[PackageExecutionHistory] does not exist.',16, 1)
        END

GO
