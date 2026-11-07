# New App Repository from Template When an Order Comes In

**Type:** Automation recipe · **Area:** Mobile · **License:** CC BY 4.0 · [Spanish original](../../../recetas/n8n/movil/crear-repo-app-nueva-desde-plantilla.md)

An n8n recipe that, when a project order arrives through a form, creates a GitHub repository from your React Native or Flutter template and notifies you.

## What it is and what it does

An n8n recipe that, when an order arrives through a form, creates the project's GitHub repository from your React Native or Flutter template, sets the client's name, and notifies you when it is ready. Input is the order data and the output is a repository with the base structure. It uses GitHub's free plan; on n8n Cloud the free plan has a limit on active workflows, whereas self-hosted does not.

## The recipe, step by step

# Automation: new app repo from template, ready in minutes

## What it's for
Every time you accept an order for a new app, instead of creating the repository by hand, copying the template, and configuring the base screens, this automation does it on its own as soon as you fill in a form. It saves the most repetitive part of starting a project: the part that is always done the same way and where it is easy to forget something.

## Accounts needed
- GitHub (or GitLab) account with a template repository already prepared with the app's base structure, in React Native or Flutter. GitHub's free plan is enough for this.
- n8n account, in the cloud (n8n.cloud, with a temporary free trial and then paid plans) or self-hosted (Community Edition, free), with no plan fee if you install it yourself.
- A form, with Typeform, Google Forms, or n8n's native form, where the project name, the framework, and the client's name are entered.
- Email or Slack account for the final notification.

## Node by node
1. Trigger: Form Trigger node, or Webhook if you use Typeform or Google Forms, which collects the project name, the chosen framework (React Native or Flutter), and the client's name.
2. Set node: cleans the project name so it works as a repository name, with no spaces or accents, in lowercase and with hyphens.
3. IF node: splits the flow according to the chosen framework, because each one uses a different template.
4. GitHub node, Create Repository from template action: creates the new repository from your React Native or Flutter template, depending on the branch of the previous IF.
5. GitHub node, Create or Update File action: edits the project's configuration file, app.json or pubspec.yaml, to set the real name of the client and the project.
6. Slack or Send Email node: notifies with the link to the new repository, ready for the team to start working.

## How to test it without messing up
Before connecting it to your real form, run it manually from n8n with test data, using a project name that doesn't exist, like test-project-delete, and check that the repository is created correctly, in a test account if you have one. Delete the test repository afterward. Don't activate it with the real form until you see one complete case working from start to finish.

## What NOT to do
- Don't give the automation a GitHub token with administrator permissions over the whole organization: create a token with permission only over repositories, to limit the damage if something fails.
- Don't leave it creating repositories in your personal account if the work is for clients: use an organization, so you don't mix work projects with your own.
- Don't assume the template keeps working the same way forever: check every so often that the template repository builds, because if not, every new project inherits the same failure.
