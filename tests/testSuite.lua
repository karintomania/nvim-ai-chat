----------------
-- feature test
----------------
package.loaded['tests/feature/asyncCurlTest'] = nil
require('tests/feature/asyncCurlTest')
----------------
-- API tests
----------------
package.loaded['tests/api/getOptionsFromChatTest'] = nil
require('tests/api/getOptionsFromChatTest')

----------------
-- Display tests
----------------
package.loaded['tests/display/BufferTest'] = nil
require('tests/display/BufferTest')

package.loaded['tests/display/ChatManagerTest'] = nil
require('tests/display/ChatManagerTest')

package.loaded['tests/display/InputManagerTest'] = nil
require('tests/display/InputManagerTest')

-- these are skipped as it requires manual checks
package.loaded['tests/display/openTabTest'] = nil
require('tests/display/openTabTest')

----------------
-- Util tests
----------------
package.loaded['tests/strUtilTest'] = nil
require('tests/strUtilTest')
