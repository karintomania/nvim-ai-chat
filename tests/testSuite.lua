----------------
-- feature test
----------------
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
package.loaded['tests/display/resultBufferTest'] = nil
require('tests/display/resultBufferTest')

-- these are skipped as it requires manual checks
-- package.loaded['tests/display/tabDisplayTest'] = nil
-- require('tests/display/tabDisplayTest')
-- package.loaded['tests/display/windowDisplayTest'] = nil
-- require('tests/display/windowDisplayTest')

----------------
-- Util tests
----------------
package.loaded['tests/strUtilTest'] = nil
require('tests/strUtilTest')
