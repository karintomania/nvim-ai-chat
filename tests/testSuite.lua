
-- feature test
-- package.loaded['tests/featureTest'] = nil
-- require('tests/featureTest')

----------------
-- API tests
----------------
package.loaded['tests/api/apiTest'] = nil
require('tests/api/apiTest')

package.loaded['tests/api/curlClientTest'] = nil
require('tests/api/curlClientTest')

package.loaded['tests/api/curlJsonResponseTest'] = nil
require('tests/api/curlJsonResponseTest')



----------------
-- Display tests
----------------
package.loaded['tests/resultPrinterTest'] = nil
require('tests/resultPrinterTest')

----------------
-- Util tests
----------------
package.loaded['tests/strUtilTest'] = nil
require('tests/strUtilTest')
