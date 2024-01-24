const cy = @import("cycle");

pub const data = cy.def.Scheme("cycle/kanban/data", .{
    cy.def.Data("Board", .{struct {
        name: cy.def.String,
        columns: cy.def.List(cy.def.This("Column")),
    }}),

    cy.def.Data("Column", .{struct {
        name: cy.def.String,
        tasks: cy.def.List(cy.def.This("Task")),
        color: cy.scm.Color,
    }}),

    cy.def.Data("Task", .{struct {
        name: cy.def.String,
        description: cy.def.String,
        ref: ?cy.def.Any,
    }}),
});

pub const Board = data.ref("Board");
pub const Column = data.ref("Column");
pub const Task = data.ref("Task");
