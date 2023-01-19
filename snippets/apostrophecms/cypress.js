  cy.get(S.contextMenuAreaItem)
    .should('be.visible')
    .then($el => {
      return $el.filter(function(i) {
        const $m = Cypress.$(this);
        return $m.find(':contains("Paste")').length === 0 &&
        $m.find(':contains("Rich Text")').length > 0;
      });
    })
    .click();
