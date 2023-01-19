// lib/moog..js
function buildCascade() {
  let cascades = [];
  for (const step of steps) {
    if (step.cascades) {
      cascades = cascades.concat(step.cascades);
    }
    for (const key of Object.keys(step)) {
      if (!(validKeys.includes(key) || cascades.includes(key))) {
        const message = upgradeHints[key] || `${key} is not a valid top level property for an Apostrophe 3.x module. Make sure you nest regular module options in the new "options" property.`;
        throw `${clarifyModuleName(step.__meta.name)}: ${message}`;
      }
    }

    for (const cascadeName of cascades) {
      if (!that[cascadeName]) {
        that[cascadeName] = {};
      }
      if (!that[`${cascadeName}Groups`]) {
        that[`${cascadeName}Groups`] = {};
      }
      // You can have access to options within a function, if you choose to provide one
      const properties = ((typeof step[cascadeName]) === 'function') ? step[cascadeName](that, options) : step[cascadeName];
      cascade.validate({
        properties,
        moduleName: clarifyModuleName(step.__meta.name),
        cascadeName
      });

      const computedCascade = cascade.build({
        source: that,
        properties,
        cascadeName
      });
      that[cascadeName] = computedCascade[cascadeName];
      that[`${cascadeName}Groups`] = computedCascade[`${cascadeName}Groups`];
    }
  }
}
