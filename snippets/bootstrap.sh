#!/bin/sh

npm init -y
npm install --save-dev eslint eslint-config-xo
mkdir lib
echo '{
  "extends": "xo/esnext",
  "rules": {
    "arrow-parens": ["error", "always"],
    "indent": ["error", 2, { "SwitchCase": 1  }],
    "semi": ["error", "never"]
  }
}' > .eslintrc.json
touch main.js
echo '$ nvim main.js'
