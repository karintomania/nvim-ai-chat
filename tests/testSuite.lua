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

-- package.loaded['tests/api/curlClientTest'] = nil
-- require('tests/api/curlClientTest')

package.loaded['tests/api/curlJsonResponseTest'] = nil
require('tests/api/curlJsonResponseTest')



----------------
-- Display tests
----------------
package.loaded['tests/display/resultBufferTest'] = nil
require('tests/display/resultBufferTest')

package.loaded['tests/display/BufferTest'] = nil
require('tests/display/BufferTest')

package.loaded['tests/display/ChatManagerTest'] = nil
require('tests/display/ChatManagerTest')

package.loaded['tests/display/InputManagerTest'] = nil
require('tests/display/InputManagerTest')

-- these are skipped as it requires manual checks
-- package.loaded['tests/display/tabDisplayTest'] = nil
-- require('tests/display/tabDisplayTest')

----------------
-- Util tests
----------------
package.loaded['tests/strUtilTest'] = nil
require('tests/strUtilTest')
